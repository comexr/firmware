#!/bin/bash
mount -t debugfs debugfs /sys/kernel/debug
echo 1 > /sys/kernel/debug/pmc_core/ltr_ignore
