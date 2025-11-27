#!/bin/bash

# ------------------------------
# Désactivation des hooks VS Code
# ------------------------------
unset __vsc_in_command_execution
unset __vsc_preexec
unset __vsc_precmd

# ------------------------------
# Désactiver les logs make
# ------------------------------
export MAKEFLAGS="--no-print-directory -s"

# ------------------------------
# Fonction pour calculer le dossier d’un paquet
# ------------------------------
get_packet_dir() {
    local packet_num=$1
    if [ "$packet_num" -eq 1 ]; then
        start=0
        end=50
    else
        start=$(( (packet_num - 1) * 50 + 1 ))
        end=$(( packet_num * 50 ))
    fi
    echo "$start $end Problem_number_${start}_to_${end}"
}

# ------------------------------
# Lister les paquets existants
# ------------------------------
list_packets() {
    i=1
    packets=()
    while true; do
        read start end dir <<< "$(get_packet_dir $i)"
        if [ -d "$dir" ]; then
            echo "  $i) $dir"
            packets+=("$dir")
            ((i++))
        else
            break
        fi
    done
}

# ------------------------------
# Choix des paquets à exécuter
# ------------------------------
echo "📦 Paquets disponibles :"
list_packets

read -rp "Entrez les numéros de paquets à exécuter (ex: 1 2 5) : " -a PACKET_NUMS

# ------------------------------
# Boucle sur chaque paquet
# ------------------------------
for PACKET in "${PACKET_NUMS[@]}"; do
    read START END DIR <<< "$(get_packet_dir "$PACKET")"
    if [ ! -d "$DIR" ]; then
        echo "❌ Paquet $PACKET ($DIR) inexistant, on passe au suivant."
        continue
    fi

    echo "📦 Paquet sélectionné : $DIR"

    # Exécution dans un sous-shell
    (
    cd "$DIR" || exit 1

    # Générer le fichier dune
    DUNE_FILE="dune"
    echo "(executables" > "$DUNE_FILE"
    echo " (names" >> "$DUNE_FILE"

    ML_FILES=( $(ls *.ml | sort -V) )
    for f in "${ML_FILES[@]}"; do
        name="${f%.ml}"
        echo "  $name" >> "$DUNE_FILE"
    done
    echo " )" >> "$DUNE_FILE"
    echo ")" >> "$DUNE_FILE"

    # Afficher les fichiers avec leur numéro réel
    echo "Fichiers disponibles dans $DIR :"
    for f in "${ML_FILES[@]}"; do
        num=$(echo "$f" | grep -oE '[0-9]+')
        echo "  $num) $f"
    done

    # Choix des fichiers à exécuter
    read -rp "Tapez les numéros des fichiers à exécuter (vide = tous) : " -a FILE_NUMS

    if [ ${#FILE_NUMS[@]} -eq 0 ]; then
        FILES_TO_RUN=( "${ML_FILES[@]}" )
    else
        FILES_TO_RUN=()
        for n in "${FILE_NUMS[@]}"; do
            idx=$(( n - START ))
            if [ "$idx" -ge 0 ] && [ "$idx" -lt "${#ML_FILES[@]}" ]; then
                FILES_TO_RUN+=( "${ML_FILES[$idx]}" )
            else
                echo "⚠️ Numéro de fichier $n invalide, ignoré."
            fi
        done
        # Si aucun fichier valide, exécuter tous
        if [ ${#FILES_TO_RUN[@]} -eq 0 ]; then
            FILES_TO_RUN=( "${ML_FILES[@]}" )
        fi
    fi

    # Compiler
    dune build &>/dev/null

    # Exécuter les fichiers
    for f in "${FILES_TO_RUN[@]}"; do
        name="${f%.ml}"
        echo "=== $name ==="
        dune exec "./$name.exe" 2>/dev/null
        echo ""
    done

    # Nettoyer
    dune clean &>/dev/null
    )
done

echo "🎉 Tous les paquets sélectionnés ont été exécutés."
