package com.example.crawling.config;

import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ProducerConfig {
    @Bean
    public Queue queue(){
        return new Queue(
                "boot.amqp.alarm-queue",
                true,
                false,
                true
        );
    }
}
