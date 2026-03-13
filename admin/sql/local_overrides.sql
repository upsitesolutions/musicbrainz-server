-- Local override tables for NoteBeast install
-- NOT part of the official MusicBrainz schema sequence.

-- Recording overrides (using MBID gid)
CREATE TABLE IF NOT EXISTS local_recording_overrides (
    recording_gid UUID PRIMARY KEY
        REFERENCES recording(gid) ON DELETE CASCADE,
    override_title TEXT,
    lyrics_original TEXT,
    is_jewish BOOLEAN DEFAULT FALSE
);

-- Artist flags (MBID)
CREATE TABLE IF NOT EXISTS local_artist_flags (
    artist_gid UUID PRIMARY KEY
        REFERENCES artist(gid) ON DELETE CASCADE,
    is_jewish BOOLEAN DEFAULT FALSE
);

-- Release flags (MBID)
CREATE TABLE IF NOT EXISTS local_release_flags (
    release_gid UUID PRIMARY KEY
        REFERENCES release(gid) ON DELETE CASCADE,
    is_jewish BOOLEAN DEFAULT FALSE
);

-- Release group flags (MBID)
CREATE TABLE IF NOT EXISTS local_releasegroup_flags (
    release_group_gid UUID PRIMARY KEY
        REFERENCES release_group(gid) ON DELETE CASCADE,
    is_jewish BOOLEAN DEFAULT FALSE
);

-- Preferred key for recordings (MBID)
CREATE TABLE IF NOT EXISTS local_recording_preferred_key (
    recording_gid UUID PRIMARY KEY REFERENCES recording(gid) ON DELETE CASCADE,
    key_value TEXT,
    is_major BOOLEAN
);

-- if the tabe local_releasegroup_flags does not have the image_generated column, add it
ALTER TABLE local_releasegroup_flags ADD COLUMN IF NOT EXISTS image_generated BOOLEAN DEFAULT FALSE;

ALTER TABLE local_artist_flags ADD COLUMN IF NOT EXISTS image_generated BOOLEAN DEFAULT FALSE;
ALTER TABLE local_artist_flags ADD COLUMN IF NOT EXISTS no_image BOOLEAN DEFAULT FALSE;

-- add a last updated column to the local_recording_overrides table and set it to the current timestamp for all existing rows and set it to update automatically on row update
ALTER TABLE local_recording_overrides ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
CREATE OR REPLACE FUNCTION update_last_updated_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_update_recording_last_updated ON local_recording_overrides;

CREATE TRIGGER trigger_update_recording_last_updated
BEFORE UPDATE ON local_recording_overrides
FOR EACH ROW
EXECUTE FUNCTION update_last_updated_column();