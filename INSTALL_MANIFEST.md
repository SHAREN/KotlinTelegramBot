# KotlinTelegramBot - Install Manifest

Installed at: 2026-03-02T22:52:26+05:00
Host user: renat

## Installed components

- Project directory: 
  -   /home/renat/KotlinTelegramBot
- Build artifact:
  -   build/libs/KotlinTelegramBot-1.0-SNAPSHOT-all.jar
- Java package installed:
  - openjdk-17-jdk
- Build tools used:
  - Gradle wrapper (project local)

## Created/used cache directories

- ~/.gradle/
- /home/renat/KotlinTelegramBot/.gradle/
- /home/renat/KotlinTelegramBot/build/

## Run command

java -jar build/libs/KotlinTelegramBot-1.0-SNAPSHOT-all.jar

> Note: bot token/config is not set by this installer.

## Uninstall checklist

1. Stop running bot process (if running):
   -    pkill -f 'java -jar.*KotlinTelegramBot' || true
2. Remove project directory:
   -    rm -rf /home/renat/KotlinTelegramBot
3. Optional: remove Gradle cache:
   -    rm -rf ~/.gradle
4. Optional: remove Java if no longer needed:
   -    sudo apt remove --purge -y openjdk-17-jdk && sudo apt autoremove --purge -y


## Autostart setup (systemd)

- Service file: /etc/systemd/system/kotlin-telegram-bot.service
- Environment file: /etc/default/kotlin-telegram-bot (contains BOT_TOKEN)
- Enable at boot: `sudo systemctl enable kotlin-telegram-bot`

Start/restart after setting token:

`sudo systemctl restart kotlin-telegram-bot`

Check logs:

`journalctl -u kotlin-telegram-bot -f`
