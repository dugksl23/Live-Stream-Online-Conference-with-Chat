package WebMvcConfig;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.servlet.config.annotation.AsyncSupportConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebMvc
public class WebMvcConfig extends WebMvcConfigurerAdapter {
//@EnableWebMvc를 붙이면 비동기기능이 자동으로 활성화
//configureAsyncSupport() 재정의

	
	 @Override
	  public void configureAsyncSupport(AsyncSupportConfigurer configurer) {
	    
		 // == 스레드풀을 이용하도록 커스터마이징한 TaskExecutor를 설정 ==
		 configurer.setDefaultTimeout(5000);
	  }
	
	  @Bean
	  public TaskExecutor mvcTaskExecutor() {
	    ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
	    executor.setCorePoolSize(5);
	    executor.setMaxPoolSize(10);
	    executor.setQueueCapacity(25);
	    return executor;
	  }
	 
}
