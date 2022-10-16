package com.group7.artshare.entity

import lombok.Data;
import javax.persistance.*;

import java.util.List;

@Data
@Entity
class Event{

    @Id
    @GeneratedValue
    private Long eventId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    Artist creator;


    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    List<Artist> collaborators;

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    List<RegisteredUser> participants;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastEdited;

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    List<Comment> commentList;

    @OneToOne
    @JoinColumn(name = "eventInfoId", referencedColumnName = "id")
    EventInfo eventInfo;
}