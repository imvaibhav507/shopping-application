package com.shopping.shoppingapplication;
import com.shopping.shoppingapplication.services.AddressService;
import com.shopping.shoppingapplication.services.CartService;
import com.shopping.shoppingapplication.services.FavouriteService;
import com.shopping.shoppingapplication.services.ProductItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class ShoppingApplication {

	@Autowired
	ProductItemService productItemService;
	@Autowired
	FavouriteService favouriteService;
	@Autowired
	AddressService cartService;


	public static void main(String[] args) {
		SpringApplication.run(ShoppingApplication.class, args);
	}

//	@Bean
//	public CommandLineRunner runner() {
//		return runner -> {
//			System.out.println(productItemService.getPopularProductItems());
//		};
//	}

}
