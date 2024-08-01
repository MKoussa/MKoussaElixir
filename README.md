# MKoussaElixir

> Visit **[MKoussa](https://www.mkoussa.com)** to see the site in action!

Built With:

![image](https://img.shields.io/badge/Elixir-4B275F?style=for-the-badge&logo=elixir&logoColor=white)
![image](https://img.shields.io/badge/Phoenix%20Framework-FD4F00?style=for-the-badge&logo=phoenixframework&logoColor=fff)
![image](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## Long Term Goals

Considering what was done with **[LiveBeats](https://fly.io/blog/livebeats/)**, I'd like to make use of **Blorp** and transform it into a sequencer that can be played, globally, by logged in users.

#### Main Quest

* Use a live queue for users to join to change a setting
* One change per user
* Limited range in setting adjustment
* Maybe 'special powers' that unlock with purchases?
    * Greater range
    * Multiple changes simultaniously
* Applies update on the beat for smooth (hopefully) synced transitions
    * possible fade into new setting?
* resets every 30 mins or daily or ??

#### Side Quests

* Chat
    * Maybe. Possibly just waves and emojis or something
* Live Background
    * Users could change color or other features
    * Only if safe

---

## Short Term Goals

### TODO

- api authentication
- setup docker compose
    - postgres
    - mkelixir
- integrate with shopify
- move db to aws
- move user to seperate live_session
- validate session/socket security
- ability to turn off all visual/graphical elements
- support features for those with disabilities

### DONE

- move /shop to liveview
- containerize db