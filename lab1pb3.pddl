
(define (problem lab1pb3)
    (:domain blocksworld)
    (:objects
        a b c d e f g h
    )

    (:init
        ;todo: put the initial state's facts and numeric values here
        (on-table b)
        (on c b)
        (on d c)
        (on e d)
        (on f e)
        (on g f)
        (on h g)
        (on a h)
        (clear a)
        (arm-empty)
    )

    (:goal
        (and
            (on-table a)
            (on b a)
            (on c b)
            (on d c)
            (on e d)
            (on f e)
            (on g f)
            (on h g)
            (clear h)
        )
    )

    ;un-comment the following line if metric is needed
    ;(:metric minimize (???))
)