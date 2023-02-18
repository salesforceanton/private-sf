export const bookedColumns = [
    { label: 'Trip', fieldName: 'link',  type: 'url', typeAttributes: {
            label: { fieldName: 'name' }
        }
    },
    { label: 'Client', fieldName: 'clientName' },
    { label: 'Preferred Start Date', type: 'date', fieldName: 'preferredTripStart' },
    { label: 'Flight', fieldName: 'flight' }
];

export const proceedColumns = [
    ...bookedColumns,
    {
        type: 'action',
        typeAttributes: { rowActions: [
                { label: 'Book', name: 'rowEdit' },
            ] 
        }
    }
]
