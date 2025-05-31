CREATE TABLE IF NOT EXISTS comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,         -- Comment belongs to a post
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,         -- User who created the comment
    parent_comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,     -- For nested comments (NULL for top-level)
    content TEXT NOT NULL,
    vote_score INTEGER DEFAULT 0,                                         -- Score for the comment, can be positive or negative
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_parent_comment_id CHECK (id <> parent_comment_id) -- A comment cannot be its own parent
);

-- This prevents a comment from being its own parent, which would create a loop
ALTER TABLE comments ADD CONSTRAINT fk_parent_comment
FOREIGN KEY (parent_comment_id) REFERENCES comments(id) ON DELETE CASCADE;

CREATE INDEX idx_comments_post_id ON comments (post_id);
CREATE INDEX idx_comments_user_id ON comments (user_id);
CREATE INDEX idx_comments_parent_comment_id ON comments (parent_comment_id);
CREATE INDEX idx_comments_created_at ON comments (created_at DESC);
CREATE INDEX idx_comments_vote_score ON comments (vote_score DESC);