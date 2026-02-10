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
