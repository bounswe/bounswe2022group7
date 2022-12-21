package com.group7.artshare.controller

import com.group7.artshare.entity.Report
import com.group7.artshare.request.ReportRequest
import com.group7.artshare.service.JwtService
import com.group7.artshare.service.ReportService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("report")
class ReportController(private val jwtService: JwtService, private val reportService: ReportService) {
    @PostMapping("")
    fun report(
        @RequestBody reportRequest: ReportRequest, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ): Report {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return reportService.reportAnItem(reportRequest, user)
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }
}