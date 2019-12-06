# Bookmark Manager

## User Stories

> As a user
> So that I remember what sites I intend to revisit
> I would like to see a list of bookmarks

## Domain Model

### Class Diagram

| Bookmark | BookmarkList |
|---|---|
| `@url` | `@bookmarks` |
| `@name` | |
|-|-| 
| `#create(name, url)` | `#show` | 
|   | `#size` | 

## Database Setup

Install `PostgreSQL` and setup for your user
Create a database called `bookmark_manager` using the command

```
$ createdb bookmark_manager
```

Open the database with

```
$ psql bookmark_manager
```

And finally, create the bookmark table by using the command in
`db/migrations/01_create_bookmarks_table.sql`

## Running the tests

Before running the tests you need to setup a test database as well. Follow the
same instructions above for creating the database but call the
database `bookmark_manager_test`.
