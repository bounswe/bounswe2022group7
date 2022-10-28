package com.group7.artshare.configuration

import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.service.RegisteredUserService
import com.group7.artshare.utils.JwtUtil
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

import java.io.IOException
import javax.servlet.FilterChain
import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse


@Component
class JwtRequestFilter(private val registeredUserService: RegisteredUserService) : OncePerRequestFilter() {
    @Value("\${security.jwt.secret-key}")
    private val secretKey: String? = null
    @Throws(ServletException::class, IOException::class)
    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        val authenticationHeader = request.getHeader("Authorization")
        if (authenticationHeader != null && authenticationHeader.startsWith("Bearer")) {
            val jwtToken = authenticationHeader.substring(7)
            val username: String? = secretKey?.let { JwtUtil.extractUsername(jwtToken, it) }
            val userDetails: UserDetails? = username?.let { registeredUserService.findByUsername(it) }
            if (SecurityContextHolder.getContext().authentication == null) {
                val token = UsernamePasswordAuthenticationToken(userDetails, null, userDetails?.authorities)
                token.details = WebAuthenticationDetailsSource().buildDetails(request)
                SecurityContextHolder.getContext().authentication = token
            }
        }
        filterChain.doFilter(request, response)
    }
}