import pluggy
from tutor import hooks
from tutormfe.hooks import MFE_APPS

@MFE_APPS.add()
def _add_custom_authoring_mfe(mfes):
    mfes["authoring"] = {
        "repository": "https://github.com/yashaswi29/frontend-app-authoring.git",
        "port": "9876",
        "version": "sumac.2",
    }
    return mfes
