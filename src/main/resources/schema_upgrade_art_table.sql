-- Use this ONLY if saving artwork fails with "Unknown column" on table `art`.
-- Run each statement in MySQL; skip any that say "Duplicate column name".

ALTER TABLE art ADD COLUMN description TEXT;
ALTER TABLE art ADD COLUMN category VARCHAR(100) NOT NULL DEFAULT 'Other';
ALTER TABLE art ADD COLUMN price DECIMAL(12,2) NOT NULL DEFAULT 0;
ALTER TABLE art ADD COLUMN image_url VARCHAR(500) NOT NULL DEFAULT '';
ALTER TABLE art ADD COLUMN sold TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE art ADD COLUMN view_count INT NOT NULL DEFAULT 0;
ALTER TABLE art ADD COLUMN sold_count INT NOT NULL DEFAULT 0;
ALTER TABLE art ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- If artist_id foreign key was never added:
-- ALTER TABLE art ADD CONSTRAINT fk_art_artist FOREIGN KEY (artist_id) REFERENCES `user`(id) ON DELETE CASCADE;
