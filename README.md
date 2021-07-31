# Top Score Ranking

## Build & Run

```shell
bundle install
bin/rake db:reset
bin/rails s -b 0.0.0.0
```

## Test

```shell
bundle exec rspec
```

## Build & Run with docker-compose

```
docker-compose build
docker-compose run web bundle exec rake db:reset
docker-comopse up
```

## API references

### GET /scores

search recoreded scores.

##### Query Parameters

* `player` - name of the plaeyr(s)
* `before` - returns scores recorded before given time
* `after` - returns scores recorded after given time
* `offset` - for paging purpose

##### Example

```
$ curl 'localhost:3000/scores?player[]=bob&after=2021-04-02&before=2021-04-03'
[{"id":3,"player":"bob","score":140,"time":"2021-04-02T00:00:00.000Z"},{"id":6,"player":"alice","score":240,"time":"2021-04-02T00:00:00.000Z"}]
```

### POST /scores

save a new score

##### body

* `player` - name of the player
* `score` - the recorded score
* `time` - the recorded time

##### Example

```
$ curl -X POST -H 'Content-Type:application/json' 'localhost:3000/scores' -d '{"player":"bob","score":300,"time":"2021-05-01 00:00:00"}'
{"id":8,"player":"bob","score":300,"time":"2021-05-01T00:00:00.000Z"}
```

### GET /players/:player/history

get the score history of a player

##### Example

```
$ curl 'localhost:3000/players/alice/history'
{"top_score":{"id":6,"player":"alice","score":240,"time":"2021-04-02T00:00:00.000Z"},"low_score":{"id":5,"player":"alice","score":200,"time":"2021-04-01T00:00:00.000Z"},"average":220,"scores":[{"id":5,"player":"alice","score":200,"time":"2021-04-01T00:00:00.000Z"},{"id":6,"player":"alice","score":240,"time":"2021-04-02T00:00:00.000Z"},{"id":7,"player":"alice","score":220,"time":"2021-04-03T00:00:00.000Z"}]}
```
