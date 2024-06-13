#include <curl/curl.h>
#include <syslog.h>
#include <stdlib.h>

int main()
{
    CURL *curl_handle;
    CURLcode res;

    openlog("healthcheck", LOG_PID | LOG_PERROR, LOG_USER);

    curl_handle = curl_easy_init();
    if (!curl_handle)
    {
        syslog(LOG_ERR, "error opening curl handle: %m\n");
        exit(EXIT_FAILURE);
    }

    // NOTE: Replace with your own healthcheck endpoint.
    curl_easy_setopt(curl_handle, CURLOPT_URL, "https://jsonplaceholder.typicode.com/posts/1");

    res = curl_easy_perform(curl_handle);
    if (res != CURLE_OK)
    {
        syslog(LOG_ERR, "error performing curl operation: %s\n", curl_easy_strerror(res));
        curl_easy_cleanup(curl_handle);
        exit(EXIT_FAILURE);
    }

    long status_code;
    curl_easy_getinfo(curl_handle, CURLINFO_RESPONSE_CODE, &status_code);

    if (status_code == 200)
    {
        syslog(LOG_INFO, "healtcheck returned 200\n");
    }
    else
    {
        syslog(LOG_ERR, "healtcheck returned %ld\n", status_code);
    }

    curl_easy_cleanup(curl_handle);

    return 0;
}
