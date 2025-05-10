#!/bin/bash

# Sürecin anlık bellek kullanımı
# Kullanım: ./check_mem.sh <PID>
# <PID> process ID'si

# 1. PID argümanı kontrolü
if [ -z "$1" ]; then
    echo "Usage: $0 <PID>"
    exit 1
fi
PID=$1

# 2. Sürecin varlığını doğrula
if ! ps -p "$PID" > /dev/null; then
    echo "Error: Process with PID $PID does not exist."
    exit 1
fi

# 3. /proc/<PID>/status dosyasından VmRSS satırını al
VMRSS=$(grep VmRSS /proc/"$PID"/status | awk '{print $2}')

# 4. VmRSS değeri bulunamazsa hata ver
if [ -z "$VMRSS" ]; then
    echo "Error: Could not retrieve VmRSS for PID $PID."
    exit 1
fi

# 5. Kilobayttan megabayta çevir (MB cinsinden, ondalıklı)
VMRSS_MB=$(echo "scale=2; $VMRSS / 1024" | bc)
#
# Sonucu yazdır
echo "Process $PID is using approximately $VMRSS_MB MB of resident memory (VmRSS)." 
