This directory contains the SQL code to be executed to produce output CSVs as specified:

- `./metrics/likes-per-minutes.csv`: time evolution: number of likes over time (minute by minute).
- `./metrics/fast-likers.csv`: fast liker: the list of all users who liked at least 50 posts in less than a minute.
- `./metrics/top-10-word.csv`: the list of the top 10 meaningful words used in posts that contain the word "engineering".
- `./metrics/posts-per-minutes.csv`: time evolution: number of posts over time (minute by minute). 
    - Although this is quite a simple metric, it highlights the benefits of the `mart` data model where metrics of the same granularity can be aggregated as part of the same model, greatly reducing the number of DB resources i.e. tables/views required to serve BI reporting needs.

Here is an example of the expected output format for the `likes-per-minutes.csv` file:

```csv
time,likes
2025-03-10 17:54:00,52985
2025-03-10 17:55:00,54736
2025-03-10 17:56:00,54736
```

or the `fast-likers.csv` file:

```csv
user_id,likes
did:plc:xaul3dllodzwvyzqf44ah4fm,898
did:plc:vjz25msr2f7izosxkro6ys55,886
did:plc:ifdj5n6n5hhmsq7udsrmckfi,760
did:plc:eh3fen366rkkf7mziyjm35d6,634
```