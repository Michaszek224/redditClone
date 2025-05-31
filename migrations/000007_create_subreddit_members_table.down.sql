CREATE TABLE IF NOT EXISTS community_members (
    community_id UUID NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (community_id, user_id) -- user can join community only once
);

CREATE INDEX idx_community_members_user_id ON community_members (user_id);
CREATE INDEX idx_community_members_community_id ON community_members (community_id);