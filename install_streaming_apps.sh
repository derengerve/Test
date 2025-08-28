#!/bin/bash

# Script d'installation d'applications de streaming pour NP2900
# Auteur: Assistant IA
# Version: 1.0

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Variables
DEVICE_IP=""
APK_DIR="./apks"
BACKUP_DIR="./backups"

# Fonctions d'affichage
print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Fonction d'aide
show_help() {
    echo "Installateur d'applications de streaming pour NP2900"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --ip IP_ADDRESS    IP de votre NP2900"
    echo "  --spotify          Installer Spotify modifié"
    echo "  --deezer           Installer Deezer modifié"
    echo "  --youtube-music    Installer YouTube Music"
    echo "  --netflix          Installer Netflix modifié"
    echo "  --kodi             Installer Kodi avec add-ons"
    echo "  --all              Installer toutes les applications"
    echo "  --backup           Sauvegarder avant installation"
    echo "  --restore          Restaurer depuis sauvegarde"
    echo "  --help             Afficher cette aide"
    echo ""
    echo "Exemple:"
    echo "  $0 --ip 192.168.1.100 --spotify --deezer"
}

# Vérifier la connexion ADB
check_adb_connection() {
    if [ -z "$DEVICE_IP" ]; then
        print_error "IP de l'appareil non spécifiée. Utilisez --ip"
        exit 1
    fi
    
    print_status "Connexion à $DEVICE_IP..."
    if adb connect "$DEVICE_IP:5555" | grep -q "connected"; then
        print_success "Connecté à $DEVICE_IP"
    else
        print_error "Impossible de se connecter à $DEVICE_IP"
        print_warning "Vérifiez que:"
        print_warning "1. Le débogage USB est activé"
        print_warning "2. L'IP est correcte"
        print_warning "3. L'appareil est sur le même réseau"
        exit 1
    fi
}

# Créer les répertoires nécessaires
create_directories() {
    mkdir -p "$APK_DIR"
    mkdir -p "$BACKUP_DIR"
}

# Télécharger les APKs
download_apks() {
    print_status "Téléchargement des APKs..."
    
    # Créer un fichier de liens (à remplir manuellement)
    cat > "$APK_DIR/download_links.txt" << 'EOF'
# Liens vers les APKs modifiés (à remplir manuellement)
# Spotify: https://example.com/spotify_androidtv.apk
# Deezer: https://example.com/deezer_androidtv.apk
# YouTube Music: https://example.com/youtube_music_androidtv.apk
# Netflix: https://example.com/netflix_androidtv.apk
# Kodi: https://example.com/kodi_androidtv.apk
EOF
    
    print_warning "Veuillez télécharger manuellement les APKs dans le dossier $APK_DIR"
    print_warning "Consultez les sources fiables:"
    print_warning "- APKMirror"
    print_warning "- XDA Developers"
    print_warning "- Reddit r/AndroidTV"
}

# Installer Spotify
install_spotify() {
    print_status "Installation de Spotify..."
    
    SPOTIFY_APK="$APK_DIR/spotify_androidtv.apk"
    if [ -f "$SPOTIFY_APK" ]; then
        if adb install -r "$SPOTIFY_APK"; then
            print_success "Spotify installé avec succès"
        else
            print_error "Échec de l'installation de Spotify"
        fi
    else
        print_warning "APK Spotify non trouvé dans $APK_DIR"
        print_warning "Téléchargez Spotify_8.7.0_AndroidTV.apk"
    fi
}

# Installer Deezer
install_deezer() {
    print_status "Installation de Deezer..."
    
    DEEZER_APK="$APK_DIR/deezer_androidtv.apk"
    if [ -f "$DEEZER_APK" ]; then
        if adb install -r "$DEEZER_APK"; then
            print_success "Deezer installé avec succès"
        else
            print_error "Échec de l'installation de Deezer"
        fi
    else
        print_warning "APK Deezer non trouvé dans $APK_DIR"
        print_warning "Téléchargez Deezer_6.2_AndroidTV.apk"
    fi
}

# Installer YouTube Music
install_youtube_music() {
    print_status "Installation de YouTube Music..."
    
    YTM_APK="$APK_DIR/youtube_music_androidtv.apk"
    if [ -f "$YTM_APK" ]; then
        if adb install -r "$YTM_APK"; then
            print_success "YouTube Music installé avec succès"
        else
            print_error "Échec de l'installation de YouTube Music"
        fi
    else
        print_warning "APK YouTube Music non trouvé dans $APK_DIR"
        print_warning "Téléchargez YouTube_Music_5.0_AndroidTV.apk"
    fi
}

# Installer Netflix
install_netflix() {
    print_status "Installation de Netflix..."
    
    NETFLIX_APK="$APK_DIR/netflix_androidtv.apk"
    if [ -f "$NETFLIX_APK" ]; then
        if adb install -r "$NETFLIX_APK"; then
            print_success "Netflix installé avec succès"
        else
            print_error "Échec de l'installation de Netflix"
        fi
    else
        print_warning "APK Netflix non trouvé dans $APK_DIR"
        print_warning "Téléchargez Netflix_8.0_AndroidTV.apk"
    fi
}

# Installer Kodi
install_kodi() {
    print_status "Installation de Kodi..."
    
    KODI_APK="$APK_DIR/kodi_androidtv.apk"
    if [ -f "$KODI_APK" ]; then
        if adb install -r "$KODI_APK"; then
            print_success "Kodi installé avec succès"
            install_kodi_addons
        else
            print_error "Échec de l'installation de Kodi"
        fi
    else
        print_warning "APK Kodi non trouvé dans $APK_DIR"
        print_warning "Téléchargez Kodi_19.0_AndroidTV.apk"
    fi
}

# Installer les add-ons Kodi
install_kodi_addons() {
    print_status "Installation des add-ons Kodi..."
    
    # Créer un fichier de configuration pour les add-ons
    cat > "$APK_DIR/kodi_addons.txt" << 'EOF'
# Add-ons Kodi recommandés pour le streaming musical
# Spotify for Kodi
# YouTube Music
# SoundCloud
# TuneIn Radio
# Pandora
EOF
    
    print_warning "Installez manuellement les add-ons dans Kodi:"
    print_warning "1. Ouvrez Kodi"
    print_warning "2. Allez dans Add-ons"
    print_warning "3. Installez depuis le dépôt"
}

# Sauvegarder les applications
backup_apps() {
    print_status "Sauvegarde des applications..."
    
    BACKUP_FILE="$BACKUP_DIR/np2900_backup_$(date +%Y%m%d_%H%M%S).ab"
    
    if adb backup -apk -shared -all -f "$BACKUP_FILE"; then
        print_success "Sauvegarde créée: $BACKUP_FILE"
    else
        print_error "Échec de la sauvegarde"
    fi
}

# Restaurer les applications
restore_apps() {
    print_status "Restauration des applications..."
    
    # Trouver le fichier de sauvegarde le plus récent
    LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/*.ab 2>/dev/null | head -1)
    
    if [ -n "$LATEST_BACKUP" ]; then
        print_status "Restauration depuis: $LATEST_BACKUP"
        if adb restore "$LATEST_BACKUP"; then
            print_success "Restauration terminée"
        else
            print_error "Échec de la restauration"
        fi
    else
        print_warning "Aucun fichier de sauvegarde trouvé"
    fi
}

# Lister les applications installées
list_installed_apps() {
    print_status "Applications installées:"
    adb shell pm list packages | grep -E "(spotify|deezer|youtube|netflix|kodi|plex)" | sed 's/package://'
}

# Nettoyer les caches
clean_caches() {
    print_status "Nettoyage des caches..."
    adb shell pm clear-cache
    print_success "Caches nettoyés"
}

# Fonction principale
main() {
    # Vérifier si ADB est installé
    if ! command -v adb &> /dev/null; then
        print_error "ADB n'est pas installé"
        print_warning "Installez Android SDK Platform Tools"
        exit 1
    fi
    
    create_directories
    
    # Traiter les arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --ip)
                DEVICE_IP="$2"
                shift 2
                ;;
            --spotify)
                INSTALL_SPOTIFY=true
                shift
                ;;
            --deezer)
                INSTALL_DEEZER=true
                shift
                ;;
            --youtube-music)
                INSTALL_YTM=true
                shift
                ;;
            --netflix)
                INSTALL_NETFLIX=true
                shift
                ;;
            --kodi)
                INSTALL_KODI=true
                shift
                ;;
            --all)
                INSTALL_ALL=true
                shift
                ;;
            --backup)
                BACKUP_BEFORE=true
                shift
                ;;
            --restore)
                RESTORE_APPS=true
                shift
                ;;
            --help)
                show_help
                exit 0
                ;;
            *)
                print_error "Option inconnue: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # Vérifier la connexion si une IP est fournie
    if [ -n "$DEVICE_IP" ]; then
        check_adb_connection
    fi
    
    # Restaurer si demandé
    if [ "$RESTORE_APPS" = true ]; then
        restore_apps
        exit 0
    fi
    
    # Sauvegarder si demandé
    if [ "$BACKUP_BEFORE" = true ]; then
        backup_apps
    fi
    
    # Installer les applications
    if [ "$INSTALL_ALL" = true ]; then
        install_spotify
        install_deezer
        install_youtube_music
        install_netflix
        install_kodi
    else
        [ "$INSTALL_SPOTIFY" = true ] && install_spotify
        [ "$INSTALL_DEEZER" = true ] && install_deezer
        [ "$INSTALL_YTM" = true ] && install_youtube_music
        [ "$INSTALL_NETFLIX" = true ] && install_netflix
        [ "$INSTALL_KODI" = true ] && install_kodi
    fi
    
    # Lister les applications installées
    list_installed_apps
    
    # Nettoyer les caches
    clean_caches
    
    print_success "Installation terminée!"
    print_warning "N'oubliez pas de configurer vos comptes dans les applications"
}

# Exécuter la fonction principale
main "$@"