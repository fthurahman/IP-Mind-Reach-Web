package com.example.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ForumDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // --- Mappers ---

    private final RowMapper<Post> postMapper = new RowMapper<Post>() {
        @Override
        public Post mapRow(ResultSet rs, int rowNum) throws SQLException {
            Post p = new Post();
            p.setId(rs.getInt("id"));
            p.setAuthor(rs.getString("author"));
            p.setTopic(rs.getString("topic"));
            p.setContent(rs.getString("content"));
            p.setStatus(rs.getString("status"));
            p.setReported(rs.getBoolean("reported"));
            p.setCreatedAt(rs.getString("created_at"));
            // Note: DB returns Timestamp/Date, but model uses String.
            // Ideally model should change, but keeping String to minimize refactor impact.
            // rs.getString will return formatted timestamp.
            return p;
        }
    };

    private final RowMapper<Comment> commentMapper = new RowMapper<Comment>() {
        @Override
        public Comment mapRow(ResultSet rs, int rowNum) throws SQLException {
            Comment c = new Comment();
            c.setId(rs.getInt("id"));
            c.setAuthor(rs.getString("author"));
            c.setContent(rs.getString("content"));
            c.setCreatedAt(rs.getString("created_at"));
            // c.setPostId(rs.getInt("post_id")); // Model doesn't have postId field yet,
            // might need it if we refactor deeper
            return c;
        }
    };

    // --- Post Actions ---

    public List<Post> getAllPosts() {
        // Only show visible/active posts
        String sql = "SELECT * FROM forum_posts WHERE status NOT IN ('removed', 'hidden') ORDER BY created_at DESC";
        List<Post> posts = jdbcTemplate.query(sql, postMapper);

        // Populate comments for each post (N+1 query, but simpler for this scale)
        for (Post p : posts) {
            p.setComments(getCommentsByPostId(p.getId()));
        }
        return posts;
    }

    public Post getPostById(int id) {
        String sql = "SELECT * FROM forum_posts WHERE id = ?";
        try {
            Post p = jdbcTemplate.queryForObject(sql, postMapper, id);
            if (p != null) {
                p.setComments(getCommentsByPostId(id));
            }
            return p;
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            return null;
        }
    }

    public void createPost(Post post) {
        String sql = "INSERT INTO forum_posts (author, topic, content, status, reported, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
        jdbcTemplate.update(sql, post.getAuthor(), post.getTopic(), post.getContent(), post.getStatus(),
                post.isReported());
    }

    public void updatePostReportStatus(int id, boolean reported, String reportedBy) {
        // 1. Update forum_posts
        String sql = "UPDATE forum_posts SET reported = ? WHERE id = ?";
        jdbcTemplate.update(sql, reported, id);

        // 2. If reported is true, insert into moderation_reports
        if (reported) {
            Post p = getPostById(id);
            if (p != null) {
                // Check if already reported to avoid duplicates (optional, but good)
                // For simplicity, just insert. Schema doesn't enforce unique reports per post-user combo but logic might want to.
                // We'll insert a new report.
                String reportSql = "INSERT INTO moderation_reports (content, author, reason, reported_by, status, post_id, created_at) " +
                                   "VALUES (?, ?, ?, ?, 'pending', ?, NOW())";
                System.out.println("DEBUG: Inserting report for Post ID: " + id + " Reported By: " + reportedBy);
                jdbcTemplate.update(reportSql, p.getContent(), p.getAuthor(), "User Reported", reportedBy, id);
            }
        }
    }

    public List<Post> searchPosts(String query) {
        String likeQuery = "%" + query + "%";
        String sql = "SELECT * FROM forum_posts WHERE (author LIKE ? OR topic LIKE ? OR content LIKE ?) AND status NOT IN ('removed', 'hidden') ORDER BY created_at DESC";
        List<Post> posts = jdbcTemplate.query(sql, postMapper, likeQuery, likeQuery, likeQuery);
        for (Post p : posts) {
            p.setComments(getCommentsByPostId(p.getId()));
        }
        return posts;
    }

    public void updatePostStatus(int id, String status) {
        String sql = "UPDATE forum_posts SET status = ? WHERE id = ?";
        jdbcTemplate.update(sql, status, id);
    }

    public List<Post> getPostsByStatus(List<String> statuses) {
        if (statuses == null || statuses.isEmpty())
            return List.of();
        // Dynamic placeholder generation -- simple implementation
        String placeholders = String.join(",", java.util.Collections.nCopies(statuses.size(), "?"));
        String sql = "SELECT * FROM forum_posts WHERE status IN (" + placeholders + ") ORDER BY created_at DESC";
        List<Post> posts = jdbcTemplate.query(sql, postMapper, statuses.toArray());
        for (Post p : posts) {
            p.setComments(getCommentsByPostId(p.getId()));
        }
        return posts;
    }

    // --- Comment Actions ---

    public List<Comment> getCommentsByPostId(int postId) {
        String sql = "SELECT * FROM forum_comments WHERE post_id = ? ORDER BY created_at ASC";
        return jdbcTemplate.query(sql, commentMapper, postId);
    }

    public void addComment(int postId, Comment comment) {
        String sql = "INSERT INTO forum_comments (post_id, author, content, created_at) VALUES (?, ?, ?, NOW())";
        jdbcTemplate.update(sql, postId, comment.getAuthor(), comment.getContent());
    }

    // --- Restore Helpers ---

    public void setPostReported(int id, boolean reported) {
        String sql = "UPDATE forum_posts SET reported = ? WHERE id = ?";
        jdbcTemplate.update(sql, reported, id);
    }

    public void updateReportStatusByPostId(int postId, String status) {
        String sql = "UPDATE moderation_reports SET status = ? WHERE post_id = ?";
        jdbcTemplate.update(sql, status, postId);
    }
}
