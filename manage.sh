#!/bin/bash
cd "$(dirname "$0")"
mkdir -p run

case "$1" in
    start)
        echo "🚀 Запуск..."
        
        pkill fcgiwrap 2>/dev/null
        rm -f run/fcgiwrap.socket
        fcgiwrap -s unix:$(pwd)/run/fcgiwrap.socket &
        sleep 0.5
        chmod 777 run/fcgiwrap.socket
        echo "   ✅ fcgiwrap"
        
        nginx -t -c $(pwd)/nginx.conf
        if [ $? -eq 0 ]; then
            nginx -c $(pwd)/nginx.conf
            echo "   ✅ nginx"
            echo ""
            echo "🌐 http://localhost:8080/cgi-bin/"
            ls -1 cgi-bin/*.cgi 2>/dev/null | sed 's/^/   /'
        fi
        ;;
        
    stop)
        echo "🛑 Остановка..."
        nginx -s stop 2>/dev/null
        pkill fcgiwrap
        rm -f run/fcgiwrap.socket
        echo "   ✅ Остановлено"
        ;;
        
    restart)
        $0 stop
        sleep 1
        $0 start
        ;;
        
    status)
        echo "📊 Статус:"
        pgrep nginx && echo "   ✅ nginx" || echo "   ❌ nginx"
        pgrep fcgiwrap && echo "   ✅ fcgiwrap" || echo "   ❌ fcgiwrap"
        [ -S run/fcgiwrap.socket ] && echo "   ✅ сокет" || echo "   ❌ сокет"
        ;;
        
    test)
        nginx -t -c $(pwd)/nginx.conf
        ;;
        
    fix)
        chmod +x cgi-bin/*.cgi 2>/dev/null
        echo "✅ Права исправлены"
        ;;
        
    *)
        echo "Использование: $0 {start|stop|restart|status|test|fix}"
        ;;
esac