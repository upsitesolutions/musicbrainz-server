/*
 * @flow strict-local
 * Copyright (C) 2024 NoteBeast
 */

import RecordingLayout from "./RecordingLayout.js";
import React from "react";

type Props = {|
    recording: RecordingT,
|};

const hasFortyPercentHebrew = (str: string) => {
    let hebrew = str.match(/[\u0590-\u05FF]/g);
    if (!hebrew) return false;
    return hebrew.length / str.length > 0.4;
};

const RecordingLyrics = ({ recording }: Props): React.Node => {
    const isThinkingHebrew = recording.lyrics && hasFortyPercentHebrew(recording.lyrics);

    return (
        <RecordingLayout page="lyrics" entity={recording} title={l("Lyrics")}>
            <div className="lyrics-container">
                <h2>{l("Lyrics")}</h2>
                <div style={{ marginBottom: "1em" }}>
                    <a 
                        href={`https://songs.notebeast.com/recording/${recording.gid}`} 
                        target="_blank" 
                        rel="noopener noreferrer"
                    >
                        {l("Edit on Notebeast")}
                    </a>
                </div>
                {recording.lyrics ? (
                    <div style={{ 
                        whiteSpace: "pre-wrap", 
                        textAlign: isThinkingHebrew ? "right" : "left", 
                        direction: isThinkingHebrew ? "rtl" : "ltr"
                    }}>
                        {recording.lyrics}
                    </div>
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
