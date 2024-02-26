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

    // Construct the path to rx_bytes file
    sprintf(path, "/sys/class/net/%s/statistics/tx_bytes", interface);

    // Open the file
    file = fopen(path, "r");
    if (file == NULL) {
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }

    // Read rx_bytes value
    fscanf(file, "%llu", &tx_bytes);

    // Close the file
    fclose(file);

    return tx_bytes;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <interface>\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char *interface = argv[1];

    while (1) {
        // Read initial rx_bytes
        unsigned long long rx_bytes_start = read_rx_bytes(interface);
	unsigned long long tx_bytes_start = read_tx_bytes(interface);
        // Sleep for 0.2 seconds
        usleep(200000);

        // Read rx_bytes after sleep
        unsigned long long rx_bytes_end = read_rx_bytes(interface);
        unsigned long long tx_bytes_end = read_tx_bytes(interface);

        // Calculate the difference
        unsigned long long tx_bytes_transferred = tx_bytes_end - tx_bytes_start;
        unsigned long long rx_bytes_transferred = rx_bytes_end - rx_bytes_start;

        // Print the result
        printf("Bytes Downloaded: %llu\n", rx_bytes_transferred);
        printf("Bytes Uploaded: %llu\n", tx_bytes_transferred);
    }

    return EXIT_SUCCESS;
}
