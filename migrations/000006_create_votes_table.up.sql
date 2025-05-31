CREATE TABLE IF NOT EXISTS votes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    entity_id UUID NOT NULL, -- The ID of the post or comment being voted on
    entity_type VARCHAR(10) NOT NULL, -- 'post' or 'comment'
    vote_type SMALLINT NOT NULL,      -- 1 for upvote, -1 for downvote
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, entity_id, entity_type) -- Ensures a user can only vote once per item
);

CREATE INDEX idx_votes_user_id ON votes (user_id);
CREATE INDEX idx_votes_entity_id_entity_type ON votes (entity_id, entity_type);