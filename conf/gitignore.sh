cat > .gitignore <<EOF
# Created by .ignore support plugin (hsz.mobi)

#package file
*.war
*.ear

#kdiff3 file
*.orig

#maven file
target/

#eclipse ignore
.settings/
.project
.classpath

#idea
.idea
*.ipr
*.iml
*.iws
out
gen

#temp file
*.log
*.cache
*.diff
*.patch
*.tmp

#system file
.DS_Store
Thmubs.db
EOF