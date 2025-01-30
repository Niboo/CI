ARG ODOO_EDITION=odoo-enterprise
ARG ODOO_VERSION=17.0
FROM registry.oodin.sh/odoo/${ODOO_EDITION}:${ODOO_VERSION}
MAINTAINER Niboo <info@niboo.com>

USER root

ARG GITHUB_TOKEN
ARG KEY


ARG ADDONS_TAG

USER odoo
# cloning client-custom addons
RUN set -x; \
    export PATH="$PATH:~/bin"\
    && cd /opt/local/odoo/ \
    && bin/install_project.sh -vp "/usr/bin/python3 --system-site-packages" -gt ${GITHUB_TOKEN} https://git:${GITHUB_TOKEN}@github.com/niboo-odoo/${KEY}.git ${ADDONS_TAG} ../odoo \
    && cd /opt/local/odoo/odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]

