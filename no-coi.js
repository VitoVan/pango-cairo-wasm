window.coi = {
  // // A function that is run to decide whether to register the SW or not.
  // You could for instance make this return a value based on whether you actually need to be cross origin isolated or not.
  shouldRegister: () => false,
  // If this function returns true, any existing service worker will be deregistered (and nothing else will happen).
  shouldDeregister: () => true,
  // A function that is run to decide whether to use "Cross-Origin-Embedder-Policy: credentialless" or not.
  // See https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cross-Origin-Embedder-Policy#browser_compatibility
  coepCredentialless: () =>
    !(navigator.userAgent.indexOf('CriOS') > -1 || !window.chrome),
  // Override this if you want to prompt the user and do reload at your own leisure. Maybe show the user a message saying:
  // "Click OK to refresh the page to enable <...>"
  doReload: () => window.location.reload(),
  // Set to true if you don't want coi to log anything to the console.
  quiet: false,
};
