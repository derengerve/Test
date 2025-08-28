#!/bin/bash

# Script d'outils pour le recyclage du NP2900 Philips
# Auteur: Assistant IA
# Version: 1.0

set -e

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction d'affichage des messages
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Fonction d'aide
show_help() {
    echo "Outils de recyclage pour NP2900 Philips"
    echo ""
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  --check-system     Vérifier les spécifications système"
    echo "  --backup-data      Sauvegarder les données importantes"
    echo "  --prepare-usb      Préparer une clé USB pour le firmware"
    echo "  --test-network     Tester la connectivité réseau"
    echo "  --clean-system     Nettoyer le système"
    echo "  --install-apps     Installer des applications utiles"
    echo "  --help             Afficher cette aide"
    echo ""
}

# Vérifier les spécifications système
check_system() {
    print_status "Vérification des spécifications système..."
    
    echo "=== Informations système ==="
    echo "Modèle: NP2900 Philips"
    echo "Architecture: $(uname -m)"
    echo "OS: $(uname -s)"
    echo "Kernel: $(uname -r)"
    
    if command -v free &> /dev/null; then
        echo "RAM: $(free -h | grep Mem | awk '{print $2}')"
    fi
    
    if command -v df &> /dev/null; then
        echo "Stockage: $(df -h / | tail -1 | awk '{print $4}') disponible"
    fi
    
    print_success "Vérification système terminée"
}

# Sauvegarder les données importantes
backup_data() {
    print_status "Sauvegarde des données importantes..."
    
    BACKUP_DIR="./np2900_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    # Sauvegarder les fichiers de configuration
    if [ -d "/etc" ]; then
        print_status "Sauvegarde des configurations système..."
        cp -r /etc "$BACKUP_DIR/" 2>/dev/null || print_warning "Impossible de sauvegarder /etc"
    fi
    
    # Sauvegarder les données utilisateur
    if [ -d "/home" ]; then
        print_status "Sauvegarde des données utilisateur..."
        cp -r /home "$BACKUP_DIR/" 2>/dev/null || print_warning "Impossible de sauvegarder /home"
    fi
    
    print_success "Sauvegarde terminée dans: $BACKUP_DIR"
}

# Préparer une clé USB pour le firmware
prepare_usb() {
    print_status "Préparation de la clé USB pour le firmware..."
    
    echo "=== Instructions pour préparer la clé USB ==="
    echo "1. Insérez une clé USB (minimum 1GB)"
    echo "2. Formatage requis: FAT32"
    echo "3. Téléchargez le firmware depuis le site Philips"
    echo "4. Copiez le fichier .bin sur la clé USB"
    echo "5. Assurez-vous que la clé est bien éjectée"
    echo ""
    
    read -p "Voulez-vous continuer avec la détection automatique de la clé USB? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v lsblk &> /dev/null; then
            echo "=== Périphériques USB détectés ==="
            lsblk | grep -E "(sd[a-z][0-9]|usb)" || print_warning "Aucun périphérique USB détecté"
        else
            print_warning "lsblk non disponible, impossible de détecter automatiquement"
        fi
    fi
}

# Tester la connectivité réseau
test_network() {
    print_status "Test de la connectivité réseau..."
    
    echo "=== Test de connectivité ==="
    
    # Test de connexion Internet
    if ping -c 1 8.8.8.8 &> /dev/null; then
        print_success "Connexion Internet: OK"
    else
        print_error "Connexion Internet: ÉCHEC"
    fi
    
    # Test DNS
    if ping -c 1 google.com &> /dev/null; then
        print_success "Résolution DNS: OK"
    else
        print_error "Résolution DNS: ÉCHEC"
    fi
    
    # Test de vitesse (si disponible)
    if command -v curl &> /dev/null; then
        print_status "Test de vitesse de téléchargement..."
        SPEED=$(curl -s -w "%{speed_download}" -o /dev/null https://www.google.com)
        echo "Vitesse de téléchargement: $SPEED bytes/sec"
    fi
}

# Nettoyer le système
clean_system() {
    print_status "Nettoyage du système..."
    
    echo "=== Nettoyage en cours ==="
    
    # Nettoyer les caches
    if [ -d "/tmp" ]; then
        print_status "Nettoyage du répertoire temporaire..."
        rm -rf /tmp/* 2>/dev/null || print_warning "Impossible de nettoyer /tmp"
    fi
    
    # Nettoyer les logs
    if [ -d "/var/log" ]; then
        print_status "Nettoyage des logs..."
        find /var/log -name "*.log" -exec truncate -s 0 {} \; 2>/dev/null || print_warning "Impossible de nettoyer les logs"
    fi
    
    # Nettoyer les packages (si applicable)
    if command -v apt-get &> /dev/null; then
        print_status "Nettoyage des packages..."
        apt-get autoremove -y 2>/dev/null || print_warning "Impossible de nettoyer les packages"
        apt-get autoclean 2>/dev/null || print_warning "Impossible d'autoclean"
    fi
    
    print_success "Nettoyage terminé"
}

# Installer des applications utiles
install_apps() {
    print_status "Installation d'applications utiles..."
    
    echo "=== Applications recommandées ==="
    echo "1. VLC Media Player"
    echo "2. Kodi"
    echo "3. Plex Media Server"
    echo "4. FileZilla (client FTP)"
    echo "5. htop (moniteur système)"
    echo ""
    
    read -p "Voulez-vous installer ces applications? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v apt-get &> /dev/null; then
            print_status "Installation via apt-get..."
            apt-get update
            apt-get install -y vlc kodi plexmediaserver filezilla htop 2>/dev/null || print_warning "Certaines applications n'ont pas pu être installées"
        elif command -v yum &> /dev/null; then
            print_status "Installation via yum..."
            yum install -y vlc kodi filezilla htop 2>/dev/null || print_warning "Certaines applications n'ont pas pu être installées"
        else
            print_warning "Gestionnaire de packages non reconnu"
        fi
    fi
}

# Fonction principale
main() {
    case "${1:-}" in
        --check-system)
            check_system
            ;;
        --backup-data)
            backup_data
            ;;
        --prepare-usb)
            prepare_usb
            ;;
        --test-network)
            test_network
            ;;
        --clean-system)
            clean_system
            ;;
        --install-apps)
            install_apps
            ;;
        --help|"")
            show_help
            ;;
        *)
            print_error "Option inconnue: $1"
            show_help
            exit 1
            ;;
    esac
}

# Vérifier si le script est exécuté en tant que root
if [ "$EUID" -eq 0 ]; then
    print_warning "Ce script est exécuté en tant que root"
fi

# Exécuter la fonction principale
main "$@"