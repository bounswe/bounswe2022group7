package com.group7.artshare.service

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.*
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class ReportService(
    private val repository: ReportRepository,
    private val artItemRepository: ArtItemRepository,
) {
    fun reportAnItem(
        reportRequest: ReportRequest,
        user: RegisteredUser
    ): Report {
        val artItem = artItemRepository.findByIdOrNull(reportRequest.artItemId)
            ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST, "There is no art item in the database with corresponding id")
        val newReport = Report()
        newReport.reporter = user
        newReport.reportedArtItem = artItem
        newReport.description = reportRequest.description
        repository.save(newReport)
        return newReport
    }
}