#!/bin/bash

npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/genereervariant/openapi.yaml
npx redocly bundle ./specificatie/openapi.yaml -o ./specificatie/genereervariant/openapi.json
