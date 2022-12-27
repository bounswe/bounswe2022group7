package com.group7.artshare.controller

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.ArtItem
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.entity.Report
import com.group7.artshare.request.ReportRequest
import com.group7.artshare.service.JwtService
import com.group7.artshare.service.ReportService
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito
import org.mockito.junit.jupiter.MockitoExtension
import org.springframework.web.server.ResponseStatusException

@ExtendWith(MockitoExtension::class)
internal class ReportControllerTest {

    @InjectMocks
    lateinit var reportController: ReportController

    @Mock
    lateinit var reportService: ReportService

    @Mock
    lateinit var jwtService: JwtService

    @Test
    fun failsToCreateIfNotHasAuthorization() {
        val mockReportRequest = ReportRequest(1,"test")
        assertThrows(ResponseStatusException::class.java) { reportController.report(mockReportRequest, "someAuthorization") }
    }

    @Test
    fun successfullyCreateReport() {
        val mockArtItem = ArtItem()
        val mockReportRequest = ReportRequest(mockArtItem.id,"test")
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        Mockito.`when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        val report = Report()
        Mockito.`when`(reportService.reportAnItem(mockReportRequest, mockUser)).thenReturn(report)
        val response = reportController.report(mockReportRequest, "authorizationHeader")
        assert(response.id == report.id)
    }
}