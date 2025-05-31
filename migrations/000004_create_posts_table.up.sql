CREATE TABLE IF NOT EXISTS posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    community_id UUID NOT NULL REFERENCES communities(id) ON DELETE CASCADE, -- Post belongs to a community
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,           -- User who created the post
    title VARCHAR(300) NOT NULL,
    content TEXT NOT NULL,                                                  
    vote_score INTEGER DEFAULT 0,                                           
    comment_count INTEGER DEFAULT 0,                                        
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_posts_community_id ON posts (community_id);
CREATE INDEX idx_posts_user_id ON posts (user_id);
CREATE INDEX idx_posts_created_at ON posts (created_at DESC); -- For sorting by new
CREATE INDEX idx_posts_vote_score ON posts (vote_score DESC); -- For sorting by hot/top