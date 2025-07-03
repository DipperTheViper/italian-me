CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE verbs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    infinitive VARCHAR(50) NOT NULL UNIQUE,
    meaning TEXT NOT NULL,
    auxiliary_verb VARCHAR(10) NOT NULL CHECK (auxiliary_verb IN ('ESSERE', 'AVERE')),
    verb_order INTEGER NOT NULL UNIQUE CHECK (verb_order > 0),

    -- Conjugations (Present Tense)
    io_present VARCHAR(50) NOT NULL,
    tu_present VARCHAR(50) NOT NULL,
    lui_present VARCHAR(50) NOT NULL,
    noi_present VARCHAR(50) NOT NULL,
    voi_present VARCHAR(50) NOT NULL,
    loro_present VARCHAR(50) NOT NULL,

    -- Past Tense
    past_participle VARCHAR(50) NOT NULL,

    -- Verb Type Classification
    irregularity_type VARCHAR(20) NOT NULL
        CHECK (irregularity_type IN (
            'REGULAR',
            'PRESENT_ONLY',
            'PAST_ONLY',
            'BOTH'
        )),

    -- Metadata
    example_sentence TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for faster queries
CREATE INDEX idx_verb_order ON verbs(verb_order);
CREATE INDEX idx_irregularity_type ON verbs(irregularity_type);