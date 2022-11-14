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
            .mvcMatchers(HttpMethod.GET, "/homepage/getGenericArtItems").permitAll()
            .mvcMatchers(HttpMethod.GET, "/homepage/getGenericEvents").permitAll()
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
