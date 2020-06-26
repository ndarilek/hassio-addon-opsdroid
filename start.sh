#!/bin/sh

mkdir -p /config/opsdroid/skills

config_file=/config/opsdroid/opsdroid.yaml

if [ ! -e "$config_file" ]; then
cat > $config_file <<EOF
logging:
  level: info

welcome-message: true

databases:
  sqlite:
    path: /config/opsdroid/opsdroid.db

connectors:
  homeassistant:
    url: http://supervisor/core/api
    token: $SUPERVISOR_TOKEN

skills:
  example:
    path: /config/opsdroid/skills/hello.py
EOF

cat > /config/opsdroid/skills/hello.py <<EOF
from opsdroid.skill import Skill
from opsdroid.matchers import match_regex

class HelloSkill(Skill):
    @match_regex(r'hi')
    async def hello(self, message):
        await message.respond('Hey')
EOF
fi

opsdroid start -f /config/opsdroid/opsdroid.yaml