WITH cols AS (
    SELECT 
        table_name,
        column_name,
        lower(data_type) AS data_type,
        ordinal_position
    FROM information_schema.columns
),
tables AS (
    SELECT DISTINCT table_name FROM cols
),
all_lines AS (
    SELECT 'Table ' || table_name || ' {' AS line, table_name, 0 AS ord
    FROM tables

    UNION ALL

    SELECT 
        '  ' || column_name || ' ' || data_type,
        table_name,
        ordinal_position
    FROM cols

    UNION ALL

    SELECT '}', table_name, 9999
    FROM tables
)
SELECT line
FROM all_lines
ORDER BY table_name, ord;