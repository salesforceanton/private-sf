export const fligtsColumns = [
    { label: 'Flight', fieldName: 'link',  type: 'url', typeAttributes: {
            label: { fieldName: 'name' }
        }
    },
    { label: 'Start', type: 'date', fieldName: 'start' },
    { label: 'Capacity', fieldName: 'capacity' },
    {
        type: 'action',
        typeAttributes: { rowActions: [
                { label: 'Select', name: 'rowSelect' },
            ] 
        }
    }
];
