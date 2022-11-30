package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import com.group7.artshare.DTO.PhysicalExhibitionDTO
import lombok.Data;
import javax.persistence.*;



@Data
@Entity
@PrimaryKeyJoinColumn(name = "id")
class PhysicalExhibition : Event(){

    @ManyToOne(fetch = FetchType.EAGER, cascade = [CascadeType.PERSIST])
    @JoinColumn(name = "location")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var location: Location? = null

    @Column
    var rules: String? = null
    override fun mapToDTO() : PhysicalExhibitionDTO {
        val dto = PhysicalExhibitionDTO()
        dto.id = this.id
        dto.creatorId = this.creator?.id
        dto.creatorAccountInfo = this.creator?.accountInfo
        dto.creationDate = this.creationDate
        dto.commentList = this.commentList.map { it.mapToDTO() }.toMutableList()
        dto.eventInfo = this.eventInfo
        dto.participantUsernames = this.participants.map { it.accountInfo.username }.toMutableList()
        dto.location = this.location
        dto.rules = this.rules
        return dto
    }
}