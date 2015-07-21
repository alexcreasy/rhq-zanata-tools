#!/bin/sh

RHQ_SCM_URL=https://github.com/rhq-project/rhq
RHQ_RELEASE_BRANCH=origin/release/jon3.3.x
TRANSLATIONS_DIR=modules/enterprise/gui/coregui/src/main/resources/org/rhq/coregui/client

echo_zanata_cfg () {
	cat <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<config xmlns="http://zanata.org/namespace/config/">
  <url>https://translate.jboss.org/</url>
  <project>jon32strings</project>
  <project-version>jon33x</project-version>
  <project-type>properties</project-type>

  <locales>
    <locale>zh-Hans</locale>
    <locale>fr</locale>
    <locale>pt-BR</locale>
    <locale>es</locale>
    <locale>de</locale>
    <locale>ja</locale>
  </locales>

</config>
EOF
}

 TMPDIR=$(mktemp -d rhqtmpXXXXXXXX)

(
	echo "Cloning RHQ repo to temp dir"
 	cd $TMPDIR
 	git clone "$RHQ_SCM_URL"
	cd rhq
	echo "Checkout $RHQ_RELEASE_BRANCH"
	git checkout "$RHQ_RELEASE_BRANCH" >/dev/null 2>&1 || echo "Error checking out branch: $RHQ_RELEASE_BRANCH"
	echo "Writing zanata.xml file"
	echo_zanata_cfg > zanata.xml
	echo "Invoking zanata-cli to push files"
	zanata-cli push --includes "Messages.properties,MessageConstants.properties" -s "$TRANSLATIONS_DIR" -t "$TRANSLATIONS_DIR"
)

echo "Cleaning up..."
rm -rf "$TMPDIR"
