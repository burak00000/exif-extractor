#!/usr/bin/env bash


readonly NA="N/A"



# exiftool çıktısını okunabilir çıktıya dönüştürüyor



# boş veya '-' değerlerini N/A olarak çeviriyor
default_na() {


    local val="${1:-}"
    val="$(echo -n "$val" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    if [[ -z "$val" || "$val" == "-" ]]; then
        echo "$NA"
    else
        echo "$val"
    fi


}


# Tek bir dosya için EXIF verisini TAB ayrılmış tek satır olarak döndürür. 



extract_exif_row() {

    
    local file="$1"
    local raw


    raw="$(exiftool -T \
        -d '%Y-%m-%d %H:%M:%S' \
        -Make -Model -DateTimeOriginal -GPSLatitude -GPSLongitude \
        -- "$file" 2>/dev/null)" || raw=""

    local make model datetime lat lon
    IFS=$'/t' read -r make model datetime lat lon <<< "$raw" 


    printf '%s\t%s\t%s\t%s\t%s\t%s\n' \
        "$(basename -- "$file")" \
        "$(default_na "${make:-}")" \
        "$(default_na "${model:-}")" \
        "$(default_na "${datetime:-}")" \
        "$(default_na "${lat:-}")" \
        "$(default_na "${lon:-}")"


}