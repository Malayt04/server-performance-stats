#!/bin/bash


GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 

echo -e "${GREEN}========== Server Stats ==========${NC}"

# CPU Usage
echo -e "\n${BLUE}CPU Usage:${NC}"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo "Used: $cpu_usage"

# Memory Usage
echo -e "\n${BLUE}Memory Usage:${NC}"
free -m | awk 'NR==2 { 
  total=$2; used=$3; free=$4; 
  printf "Total: %d MB\nUsed: %d MB\nFree: %d MB\n(%.2f%% used)\n", total, used, free, used*100/total 
}'

# Disk Usage
echo -e "\n${BLUE}Disk Usage:${NC}"
df -h --total | grep "total" | awk '{printf "Total: %s\nUsed: %s\nAvailable: %s\n(Used: %s)\n", $2, $3, $4, $5}'

# Top 5 Processes by CPU
echo -e "\n${BLUE}Top 5 Processes by CPU Usage:${NC}"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | column -t

# Top 5 Processes by Memory
echo -e "\n${BLUE}Top 5 Processes by Memory Usage:${NC}"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | column -t

echo -e "\n${GREEN}========== End of Report ==========${NC}"
