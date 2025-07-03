# Użyj oficjalnego obrazu Debian 12 (Bookworm) jako obrazu bazowego.
# Jest to lekka i stabilna podstawa dla naszego kontenera.
FROM debian:12

# Ustaw etykietę, aby zidentyfikować autora obrazu.
LABEL maintainer="TwojeImię <twoj.email@example.com>"

# Zaktualizuj listę pakietów i zainstaluj niezbędne narzędzia w jednej warstwie.
# Użycie `&&` łączy komendy, co optymalizuje rozmiar finalnego obrazu.
# - `apt-get update`: Odświeża listę dostępnych pakietów.
# - `apt-get install -y`: Instaluje pakiety bez interaktywnego potwierdzania.
#   - `zip`: Narzędzie do kompresji i dekompresji archiwów .zip.
#   - `git`: System kontroli wersji.
#   - `cmake`: Narzędzie do automatyzacji budowania oprogramowania.
#   - `build-essential`: Metapakiet zawierający kompilatory (gcc, g++) i `make`.
# - `rm -rf /var/lib/apt/lists/*`: Usuwa zbędne pliki pamięci podręcznej apt,
#   aby zmniejszyć rozmiar obrazu.
RUN apt-get update && \
    apt-get install -y \
    zip \
    git \
    cmake \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Ustaw domyślny katalog roboczy wewnątrz kontenera.
# Wszystkie kolejne komendy będą wykonywane w tym folderze.
WORKDIR /app

# Skopiuj wszystkie pliki z bieżącego katalogu (kontekstu budowania)
# do katalogu roboczego /app wewnątrz kontenera.
COPY . /app

# Ustaw domyślną komendę, która zostanie wykonana po uruchomieniu kontenera.
# Uruchomienie powłoki `bash` pozwala na interaktywną pracę z kontenerem.
CMD ["bash"]
