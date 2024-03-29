package com.group7.artshare.configuration

import com.group7.artshare.service.CustomAuthenticationProvider
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpMethod
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter


// THIS CODE IS TAKEN FROM https://github.com/fatihdogmus/yte-intern-spring-security/tree/intern-2021-1-jwt
// LITTLE OR NO MODIFICATIONS HAVE BEEN MADE TO THE CODE

@EnableWebSecurity
@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
class SecurityConfiguration @Autowired constructor(
    customAuthenticationProvider: CustomAuthenticationProvider,
    jwtRequestFilter: JwtRequestFilter
) :
    WebSecurityConfigurerAdapter() {
    private val customAuthenticationProvider: CustomAuthenticationProvider
    private val jwtRequestFilter: JwtRequestFilter

    init {
        this.customAuthenticationProvider = customAuthenticationProvider
        this.jwtRequestFilter = jwtRequestFilter
    }

    @Throws(Exception::class)
    override fun configure(auth: AuthenticationManagerBuilder) {
        auth.authenticationProvider(customAuthenticationProvider)
    }

    @Throws(Exception::class)
    override fun configure(http: HttpSecurity) {
        http
            .authorizeRequests()
            .antMatchers("/v3/api-docs", "/configuration/ui", "/swagger-resources/**", "/configuration/**", "/swagger-ui.html", "/webjars/**").permitAll()
            .regexMatchers(".*swagger.*").permitAll()
            .antMatchers(HttpMethod.POST,"/login").permitAll()
            .antMatchers(HttpMethod.POST,"/signup").permitAll()
            .mvcMatchers(HttpMethod.GET, "/event/{id}").permitAll()
            .mvcMatchers(HttpMethod.GET, "/art_item/{id}").permitAll()
            .mvcMatchers(HttpMethod.GET, "/homepage/artItem").permitAll()
            .mvcMatchers(HttpMethod.GET, "/homepage/event").permitAll()
            .mvcMatchers(HttpMethod.GET, "/profile/{username}").permitAll()
            .mvcMatchers(HttpMethod.GET, "/discussionPost").permitAll()
            .mvcMatchers(HttpMethod.GET, "/discussionPost/{id}").permitAll()
            .mvcMatchers(HttpMethod.GET, "/image/{id}").permitAll()
            .mvcMatchers(HttpMethod.GET, "/search_art_item").permitAll()
            .mvcMatchers(HttpMethod.GET, "/search_physical_exhibition").permitAll()
            .mvcMatchers(HttpMethod.GET, "/search_online_gallery").permitAll()
            .mvcMatchers(HttpMethod.GET, "/search_discussion_post").permitAll()
            .mvcMatchers(HttpMethod.GET, "/search_user").permitAll()
            .anyRequest().authenticated()
            .and()
            .sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            .and()
            .addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter::class.java)
            .formLogin().disable()
            .csrf().disable()
    }

    @Bean
    @Throws(Exception::class)
    public override fun authenticationManager(): AuthenticationManager {
        return super.authenticationManager()
    }
}
