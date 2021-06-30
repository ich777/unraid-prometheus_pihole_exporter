# Clone repository and compile PiHole Exporter
cd ${DATA_DIR}
git clone https://github.com/eko/pihole-exporter.git
cd ${DATA_DIR}/pihole-exporter
git checkout v$LAT_V
GO111MODULE=on go mod vendor
GOOS=linux GOARCH=amd64 go build -o pihole_exporter .

# Create directories and copy files to destination
mkdir -p ${DATA_DIR}/v${LAT_V} ${DATA_DIR}/${LAT_V}/usr/bin
cp ${DATA_DIR}/pihole-exporter/pihole_exporter ${DATA_DIR}/${LAT_V}/usr/bin/prometheus_pihole_exporter

# Download plugin page and executables and move it to destination
wget -q -O ${DATA_DIR}/sourcepkg.txz https://github.com/ich777/unraid-prometheus_pihole_exporter/raw/master/source/sourcepackage.txz
tar -C ${DATA_DIR}/${LAT_V} -xvf ${DATA_DIR}/sourcepkg.txz
cd ${DATA_DIR}/${LAT_V}

# Create Slackware package
makepkg -l y -c y ${DATA_DIR}/v$LAT_V/$APP_NAME-"$(date +'%Y.%m.%d')".tgz
cd ${DATA_DIR}/v$LAT_V
md5sum $APP_NAME-"$(date +'%Y.%m.%d')".tgz | awk '{print $1}' > $APP_NAME-"$(date +'%Y.%m.%d')".tgz.md5