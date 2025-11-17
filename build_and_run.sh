#!/bin/bash

# Nom du fichier dune
DUNE_FILE="dune"

echo "🔹 Génération du fichier dune..."

# Générer le fichier dune avec tous les fichiers .ml
echo "(executables" > "$DUNE_FILE"
echo " (names" >> "$DUNE_FILE"
for f in *.ml; do
    name="${f%.ml}"
    echo "  $name" >> "$DUNE_FILE"
done
echo " )" >> "$DUNE_FILE"
echo ")" >> "$DUNE_FILE"

echo "✅ Fichier dune généré."

# Compiler tous les fichiers
echo "🔹 Compilation avec Dune..."
dune build
echo "✅ Compilation terminée."

# Exécuter tous les exécutables
echo "🔹 Exécution de tous les problèmes..."
for f in *.ml; do
    name="${f%.ml}"
    echo "=== $name ==="
    dune exec "./$name.exe"
    echo ""
done

echo "🎉 Tous les problèmes ont été exécutés."

# Nettoyer le projet (équivalent make clean)
echo "🧹 Nettoyage des fichiers générés..."
dune clean
echo "✅ Nettoyage terminé."