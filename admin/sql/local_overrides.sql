-- Local override tables for NoteBeast install
-- NOT part of the official MusicBrainz schema sequence.

-- Recording-level overrides (title + lyrics + flags)
CREATE TABLE IF NOT EXISTS local_recording_overrides (
    recording_id UUID PRIMARY KEY
        REFERENCES recording(id) ON DELETE CASCADE,
    override_title TEXT,
    lyrics_original TEXT,
    is_jewish BOOLEAN DEFAULT FALSE
);

-- Artist-level flag
CREATE TABLE IF NOT EXISTS local_artist_flags (
    artist_id UUID PRIMARY KEY
        REFERENCES artist(id) ON DELETE CASCADE,
    is_jewish BOOLEAN DEFAULT FALSE
);

-- Release-level flag
CREATE TABLE IF NOT EXISTS local_release_flags (
    release_id UUID PRIMARY KEY
        REFERENCES release(id) ON DELETE CASCADE,
    is_jewish BOOLEAN DEFAULT FALSE
);

-- Release group–level flag
CREATE TABLE IF NOT EXISTS local_releasegroup_flags (
    release_group_id UUID PRIMARY KEY
        REFERENCES release_group(id) ON DELETE CASCADE,
    is_jewish BOOLEAN DEFAULT FALSE
);
