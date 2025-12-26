package com.example.ecommerce.config;

import com.example.ecommerce.model.Product;
import com.example.ecommerce.repository.ProductRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataSeeder {

    @Bean
    CommandLineRunner seedProducts(ProductRepository repository) {
        return args -> {
            if (repository.count() > 0) {
                return;
            }
            repository.save(new Product(
                    "Wireless Headphones",
                    "Noise cancelling over-ear headphones with 30h battery.",
                    129.99,
                    "https://via.placeholder.com/200x200.png?text=Headphones"
            ));
            repository.save(new Product(
                    "Smart Watch",
                    "Fitness tracking, notifications, and 3-day battery life.",
                    89.50,
                    "https://via.placeholder.com/200x200.png?text=Watch"
            ));
            repository.save(new Product(
                    "Mechanical Keyboard",
                    "Tactile switches with RGB lighting and detachable cable.",
                    74.25,
                    "https://via.placeholder.com/200x200.png?text=Keyboard"
            ));
            repository.save(new Product(
                    "Portable Speaker",
                    "Water-resistant speaker with deep bass and 12h playtime.",
                    59.99,
                    "https://via.placeholder.com/200x200.png?text=Speaker"
            ));
        };
    }
}


