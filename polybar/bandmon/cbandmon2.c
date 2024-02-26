#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// Function to read rx_bytes from sysfs
unsigned long long read_rx_bytes(const char *interface) {
    unsigned long long rx_bytes = 0;
    char path[100];
    FILE *file;

    // Construct the path to rx_bytes file
    sprintf(path, "/sys/class/net/%s/statistics/rx_bytes", interface);

    // Open the file
    file = fopen(path, "r");
    if (file == NULL) {
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }

    // Read rx_bytes value
    fscanf(file, "%llu", &rx_bytes);

    // Close the file
    fclose(file);

    return rx_bytes;
}

unsigned long long read_tx_bytes(const char *interface) {
    unsigned long long tx_bytes = 0;
    char path[100];
    FILE *file;

    // Construct the path to tx_bytes file
    sprintf(path, "/sys/class/net/%s/statistics/tx_bytes", interface);

    // Open the file
    file = fopen(path, "r");
    if (file == NULL) {
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }

    // Read tx_bytes value
    fscanf(file, "%llu", &tx_bytes);

    // Close the file
    fclose(file);

    return tx_bytes;
}

int main(int argc, char *argv[]) {

    const char *interface = "wlan0";

    while (1) {
        // Read initial rx_bytes and tx_bytes
        unsigned long long rx_bytes_start = read_rx_bytes(interface);
        unsigned long long tx_bytes_start = read_tx_bytes(interface);

        // Sleep for 1 second
        sleep(1);

        // Read rx_bytes and tx_bytes after sleep
        unsigned long long rx_bytes_end = read_rx_bytes(interface);
        unsigned long long tx_bytes_end = read_tx_bytes(interface);

        // Calculate the difference in bytes
        unsigned long long tx_bytes_transferred = tx_bytes_end - tx_bytes_start;
        unsigned long long rx_bytes_transferred = rx_bytes_end - rx_bytes_start;

        // Calculate transfer rates in KB/s
        double tx_rate = (double)tx_bytes_transferred / 1024;
        double rx_rate = (double)rx_bytes_transferred / 1024;

        // Print the result on the same line
        printf("Down: %.2f KB/s | Up: %.2f KB/s\r", rx_rate, tx_rate);
        fflush(stdout); // Flush output buffer to ensure it's printed immediately
    }

    return EXIT_SUCCESS;
}
