/*
 * @flow strict-local
 * Copyright (C) 2024 NoteBeast
 */

import RecordingLayout from "./RecordingLayout.js";
import React from "react";

type Props = {|
    recording: RecordingT,
|};

const RecordingLyrics = ({ recording }: Props): React.Node => {
    return (
        <RecordingLayout page="lyrics" entity={recording} title={l("Lyrics")}>
            <div className="lyrics-container">
                <h2>{l("Lyrics")}</h2>
                {recording.lyrics ? (
                    <div style={{ whiteSpace: "pre-wrap" }}>{recording.lyrics}</div>
                ) : (
                    <p>
                        <em>{l("No lyrics available for this recording.")}</em>
                    </p>
                )}
            </div>
        </RecordingLayout>
    );
};

export default RecordingLyrics;
