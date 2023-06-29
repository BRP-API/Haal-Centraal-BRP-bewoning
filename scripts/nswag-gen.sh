#!/bin/bash

nswag run src/BewoningService/Server.nswag /runtime:Net60
nswag run src/BewoningProxy/DataTransferObjects.nswag /runtime:Net60
nswag run src/BewoningProxy/GbaDataTransferObjects.nswag /runtime:Net60
